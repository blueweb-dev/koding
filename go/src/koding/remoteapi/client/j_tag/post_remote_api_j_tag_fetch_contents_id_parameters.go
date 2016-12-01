package j_tag

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"
)

// NewPostRemoteAPIJTagFetchContentsIDParams creates a new PostRemoteAPIJTagFetchContentsIDParams object
// with the default values initialized.
func NewPostRemoteAPIJTagFetchContentsIDParams() *PostRemoteAPIJTagFetchContentsIDParams {
	var ()
	return &PostRemoteAPIJTagFetchContentsIDParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJTagFetchContentsIDParamsWithTimeout creates a new PostRemoteAPIJTagFetchContentsIDParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJTagFetchContentsIDParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJTagFetchContentsIDParams {
	var ()
	return &PostRemoteAPIJTagFetchContentsIDParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJTagFetchContentsIDParamsWithContext creates a new PostRemoteAPIJTagFetchContentsIDParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJTagFetchContentsIDParamsWithContext(ctx context.Context) *PostRemoteAPIJTagFetchContentsIDParams {
	var ()
	return &PostRemoteAPIJTagFetchContentsIDParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJTagFetchContentsIDParams contains all the parameters to send to the API endpoint
for the post remote API j tag fetch contents ID operation typically these are written to a http.Request
*/
type PostRemoteAPIJTagFetchContentsIDParams struct {

	/*ID
	  Mongo ID of target instance

	*/
	ID string

	timeout time.Duration
	Context context.Context
}

// WithTimeout adds the timeout to the post remote API j tag fetch contents ID params
func (o *PostRemoteAPIJTagFetchContentsIDParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJTagFetchContentsIDParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j tag fetch contents ID params
func (o *PostRemoteAPIJTagFetchContentsIDParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j tag fetch contents ID params
func (o *PostRemoteAPIJTagFetchContentsIDParams) WithContext(ctx context.Context) *PostRemoteAPIJTagFetchContentsIDParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j tag fetch contents ID params
func (o *PostRemoteAPIJTagFetchContentsIDParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithID adds the id to the post remote API j tag fetch contents ID params
func (o *PostRemoteAPIJTagFetchContentsIDParams) WithID(id string) *PostRemoteAPIJTagFetchContentsIDParams {
	o.SetID(id)
	return o
}

// SetID adds the id to the post remote API j tag fetch contents ID params
func (o *PostRemoteAPIJTagFetchContentsIDParams) SetID(id string) {
	o.ID = id
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJTagFetchContentsIDParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	// path param id
	if err := r.SetPathParam("id", o.ID); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}