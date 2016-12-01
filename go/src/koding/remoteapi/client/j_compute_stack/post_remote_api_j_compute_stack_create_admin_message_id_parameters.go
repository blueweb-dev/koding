package j_compute_stack

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

// NewPostRemoteAPIJComputeStackCreateAdminMessageIDParams creates a new PostRemoteAPIJComputeStackCreateAdminMessageIDParams object
// with the default values initialized.
func NewPostRemoteAPIJComputeStackCreateAdminMessageIDParams() *PostRemoteAPIJComputeStackCreateAdminMessageIDParams {
	var ()
	return &PostRemoteAPIJComputeStackCreateAdminMessageIDParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJComputeStackCreateAdminMessageIDParamsWithTimeout creates a new PostRemoteAPIJComputeStackCreateAdminMessageIDParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJComputeStackCreateAdminMessageIDParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJComputeStackCreateAdminMessageIDParams {
	var ()
	return &PostRemoteAPIJComputeStackCreateAdminMessageIDParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJComputeStackCreateAdminMessageIDParamsWithContext creates a new PostRemoteAPIJComputeStackCreateAdminMessageIDParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJComputeStackCreateAdminMessageIDParamsWithContext(ctx context.Context) *PostRemoteAPIJComputeStackCreateAdminMessageIDParams {
	var ()
	return &PostRemoteAPIJComputeStackCreateAdminMessageIDParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJComputeStackCreateAdminMessageIDParams contains all the parameters to send to the API endpoint
for the post remote API j compute stack create admin message ID operation typically these are written to a http.Request
*/
type PostRemoteAPIJComputeStackCreateAdminMessageIDParams struct {

	/*ID
	  Mongo ID of target instance

	*/
	ID string

	timeout time.Duration
	Context context.Context
}

// WithTimeout adds the timeout to the post remote API j compute stack create admin message ID params
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJComputeStackCreateAdminMessageIDParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j compute stack create admin message ID params
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j compute stack create admin message ID params
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) WithContext(ctx context.Context) *PostRemoteAPIJComputeStackCreateAdminMessageIDParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j compute stack create admin message ID params
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithID adds the id to the post remote API j compute stack create admin message ID params
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) WithID(id string) *PostRemoteAPIJComputeStackCreateAdminMessageIDParams {
	o.SetID(id)
	return o
}

// SetID adds the id to the post remote API j compute stack create admin message ID params
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) SetID(id string) {
	o.ID = id
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJComputeStackCreateAdminMessageIDParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

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