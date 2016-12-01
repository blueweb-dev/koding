package j_workspace

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// NewPostRemoteAPIJWorkspaceCreateParams creates a new PostRemoteAPIJWorkspaceCreateParams object
// with the default values initialized.
func NewPostRemoteAPIJWorkspaceCreateParams() *PostRemoteAPIJWorkspaceCreateParams {
	var ()
	return &PostRemoteAPIJWorkspaceCreateParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJWorkspaceCreateParamsWithTimeout creates a new PostRemoteAPIJWorkspaceCreateParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJWorkspaceCreateParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJWorkspaceCreateParams {
	var ()
	return &PostRemoteAPIJWorkspaceCreateParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJWorkspaceCreateParamsWithContext creates a new PostRemoteAPIJWorkspaceCreateParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJWorkspaceCreateParamsWithContext(ctx context.Context) *PostRemoteAPIJWorkspaceCreateParams {
	var ()
	return &PostRemoteAPIJWorkspaceCreateParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJWorkspaceCreateParams contains all the parameters to send to the API endpoint
for the post remote API j workspace create operation typically these are written to a http.Request
*/
type PostRemoteAPIJWorkspaceCreateParams struct {

	/*Body
	  body of the request

	*/
	Body *models.DefaultSelector

	timeout time.Duration
	Context context.Context
}

// WithTimeout adds the timeout to the post remote API j workspace create params
func (o *PostRemoteAPIJWorkspaceCreateParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJWorkspaceCreateParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j workspace create params
func (o *PostRemoteAPIJWorkspaceCreateParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j workspace create params
func (o *PostRemoteAPIJWorkspaceCreateParams) WithContext(ctx context.Context) *PostRemoteAPIJWorkspaceCreateParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j workspace create params
func (o *PostRemoteAPIJWorkspaceCreateParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithBody adds the body to the post remote API j workspace create params
func (o *PostRemoteAPIJWorkspaceCreateParams) WithBody(body *models.DefaultSelector) *PostRemoteAPIJWorkspaceCreateParams {
	o.SetBody(body)
	return o
}

// SetBody adds the body to the post remote API j workspace create params
func (o *PostRemoteAPIJWorkspaceCreateParams) SetBody(body *models.DefaultSelector) {
	o.Body = body
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJWorkspaceCreateParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	if o.Body == nil {
		o.Body = new(models.DefaultSelector)
	}

	if err := r.SetBodyParam(o.Body); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}